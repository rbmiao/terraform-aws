output "public_ip" {
  value		  = aws_instance.terraform-instance.public_ip
  description = "The public IP of the web server"
}