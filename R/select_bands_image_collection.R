#' Select bands from  image collection
#' @return ee.Image.Collection() with bands selected
#' @author Alec L. Robitaille
#' @export
select_bands_image_collection <- function(image_collection, band_names) {
	image_collection |>
		ee$ImageCollection$select(band_names)
}
