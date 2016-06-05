#!/bin/bash

CDN_S3_BUCKET="cdn.niklaslindblad.se"

s3cmd --recursive modify --add-header="Cache-Control:max-age=315532800" s3://${CDN_S3_BUCKET}/images
s3cmd --recursive modify --add-header="Expires:Mon, 09 Mar 2026 16:00:00 GMT" s3://${CDN_S3_BUCKET}/images

