#' Get example features
#' @return
#' @param region_size size of example study region's (in this case, a circle's diameter in meters)
#' @param type either 'points', or 'polygons'
#' @author Alec L. Robitaille
#' @export
get_example_features <- function(x, y, type = 'points', region_size, n_features) {
	xy_pt <- st_point(c(x, y))
	xy_buff <- st_buffer(xy_pt, region_size)

	xy_sample <- st_sample(xy_buff, n_features)
	xy <- data.frame(id = seq.int(n_features))
	xy$geometry <- xy_sample

	out_point <- st_as_sf(xy, crs = 4326)

	if (type == 'polygons') {
		grd <- st_make_grid(out_point)
		out_poly <- grd[st_sample(st_make_grid(out_point), n_features)]
		return(out_poly)
	} else {
		return(out_point)
	}
}
