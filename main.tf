resource "random_id" "suffix" {
  byte_length = 3
}

locals {
  vpc_name              = "${var.prefix}-${var.environment}-${var.name}-${random_id.suffix.hex}"
  subnet_name           = "${var.prefix}-${var.environment}-${var.name}-${random_id.suffix.hex}"
  secondary_ranges_name = "${var.prefix}-${var.environment}-${var.name}-${random_id.suffix.hex}"
  cluster_name          = "${var.prefix}-${var.environment}-${var.name}-${random_id.suffix.hex}"
}