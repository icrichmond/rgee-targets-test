#' Filter image collection using bounds of a provided region (feature)
#' @return filtered ee.Image.Collection()
#' @author Alec L. Robitaille
#' @export
filter_bounds <- function(image_collection, region) {
	image_collection |>
		ee$ImageCollection$filterBounds(sf_as_ee(st_as_sfc(st_bbox(region))))
}
