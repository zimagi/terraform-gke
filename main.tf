resource "random_id" "suffix" {
  byte_length = 3
}

locals {
  vpc_name              = "${var.prefix}-${var.environment}-${var.name}"
  subnet_name           = "${var.prefix}-${var.environment}-${var.name}"
  secondary_ranges_name = "${var.prefix}-${var.environment}-${var.name}"
  cluster_name          = "${var.prefix}-${var.environment}-${var.name}"
}
