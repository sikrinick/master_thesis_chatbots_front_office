#!/usr/bin/env python3

import groupdocs_conversion_cloud

from os.path import dirname, realpath, join
from os import chdir, listdir, remove, getenv
from subprocess import run
from typing import Set
from shutil import move

script_dir = dirname(realpath(__file__))
chdir(script_dir)

input_file = "master_thesis.tex"
output_pdf_file_name = "master_thesis.pdf"
output_docx_file_name= "master_thesis.docx"

output_root = "output"
output_pdf_dir = join(output_root, "pdf")
output_docx_dir = join(output_root, "docx")
        
# build pdf
run([
    "latexmk",
    "-xelatex",
    "-synctex=1",
    "-interaction=nonstopmode",
    "-file-line-error",
    f"-outdir={output_pdf_dir}",
    f'"{input_file}"'
])
print("\n")
output_pdf_file = join(output_pdf_dir, output_pdf_file_name)
print(f"PDF file is in {output_pdf_file}")

# pdf => docx
print("\n")
groupdocs_client_id = getenv("GROUPDOCS_CLIENT_ID")
groupdocs_client_secret = getenv("GROUPDOCS_CLIENT_SECRET")
print(f"GroupDocs CLIENT_ID: {groupdocs_client_id}")
print(f"GroupDocs CLIENT_SECRET: {groupdocs_client_secret}")
print("\n")

if groupdocs_client_id is None or groupdocs_client_secret is None:
    print("GroupDocs settings are not specified. PDF to DOCX conversion cannot be done automatically")
    print("Use https://products.groupdocs.app/conversion/pdf-to-docx")
    quit()

convert_api = groupdocs_conversion_cloud.ConvertApi.from_keys(groupdocs_client_id, groupdocs_client_secret)
file_api = groupdocs_conversion_cloud.FileApi.from_keys(groupdocs_client_id, groupdocs_client_secret)


## upload pdf to GroupDocs storage
upload_file = join(output_pdf_dir, output_pdf_file_name)
remote_name = output_pdf_file_name

print(f"Uploading {upload_file} as {remote_name}")
request_upload = groupdocs_conversion_cloud.UploadFileRequest(remote_name, upload_file)
response_upload = file_api.upload_file(request_upload)
print("Finished upload")
print("\n")

## convert in cloud pdf => docx
conversion_settings = groupdocs_conversion_cloud.ConvertSettings()
conversion_settings.file_path = remote_name
conversion_settings.format = "docx"
conversion_settings.output_path = output_docx_file_name

print(f"Converting {conversion_settings.file_path} to {output_docx_file_name}")
request = groupdocs_conversion_cloud.ConvertDocumentRequest(conversion_settings)
response = convert_api.convert_document(request)
print("Finished conversion")
print("\n")

## download from cloud
print(f"Downloading {output_docx_file_name}")
request_download = groupdocs_conversion_cloud.DownloadFileRequest(output_docx_file_name)
response_download = file_api.download_file(request_download)
print("Finished download")
print("\n")

## move to output
output_docx_file = join(output_docx_dir, output_docx_file_name)
move(response_download, output_docx_file)
print(f"DOCX file is in {output_docx_file}")