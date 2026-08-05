resource "aws_kms_key" "eks" {

  description = "KMS Key for ${var.project_name}"

  deletion_window_in_days = 7

  enable_key_rotation = true

  tags = {

    Name = "${var.project_name}-${var.environment}-kms"

  }

}
resource "aws_kms_alias" "eks" {

  name = "alias/${var.project_name}-${var.environment}"

  target_key_id = aws_kms_key.eks.key_id

}
