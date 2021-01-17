test_that("calculateGeographicalDistance works", {
  expect_equal(
    calculateGeographicalDistance(57.60287, 57.62190, 11.66572, 11.67703),
    geosphere::distm(x = c(57.60287, 11.66572), y = c(57.62190, 11.67703), geosphere::distHaversine)[1,1]
  )

  expect_equal(calculateGeographicalDistance(52.2297, 52.2297, 21.0122, 21.0122), 0)
})

