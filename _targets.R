# === Targets rgee extract ------------------------------------------------
# Alec L. Robitaille



# Source ------------------------------------------------------------------
targets::tar_source('R')



# Variables ---------------------------------------------------------------

# Images
dsm_asset_id <- 'projects/sat-io/open-datasets/OPEN-CANADA/CAN_ELV/HRDEM_1M_DSM'
dtm_asset_id <- 'projects/sat-io/open-datasets/OPEN-CANADA/CAN_ELV/HRDEM_1M_DTM'
elev_scale <- 1

# Reducers
reducer_mean <- ee$Reducer$mean()

# Via argument for ee_extract
# either "getInfo" for extracting directly (note this can be limiting),
# "drive" for extracting via Google Drive (requires googledrive package),
# or "gcs" for extracting via Google Cloud Storage (requires googleCloudStorageR package)
via <- 'getInfo'



# Data --------------------------------------------------------------------
# Microsoft building data
buildings_asset_id <- 'projects/sat-io/open-datasets/MSBuildings'





# Targets: prep ee data ---------------------------------------------------
targets_data_prep <- c(

	tar_target(
		dsm,
		get_ee_image(dsm_asset_id)
	),

	tar_target(
		dtm,
		get_ee_image(dtm_asset_id)
	),

	tar_target(
		elev,
		ee$Array$subtract(ee$ImageCollection$mosaic(dsm), ee$ImageCollection$mosaic(dtm))
	),








)




# Targets: sample image with points ---------------------------------------
# For example, leading tree species at points
targets_image_points <- c(
	tar_target(
		sample_image_with_points,
		ee_extract(
			get_ee_image(tree_species_asset_id),
			points,
			scale = tree_species_scale,
			fun = reducer_mean,
			sf = TRUE
		)
	)
)





# Targets: README ---------------------------------------------------------
targets_readme <- c(
	tar_render(
		render_readme,
		'README.Rmd'
	),
	tar_target(
		rm_html,
		{render_readme; file.remove('README.html')}
	)
)




# Targets: all ------------------------------------------------------------
# Automatically grab all the 'targets_*' lists above
lapply(grep('targets', ls(), value = TRUE), get)
