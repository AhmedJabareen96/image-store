import boto3
import datetime
import file_object as fo
from PIL import Image
import os, glob, mysql

BUCKET_NAME = "amdjab-img-store-bucket"

def print_bucket_names():
    s3 = boto3.resource("s3")
    for bucket in s3.buckets.all():
        print(bucket.name)

def upload_file(file_name):
    s3 = boto3.client("s3")
    # test image
    image = Image.open('data/'+file_name)
    s3.upload_file(
        Filename="data/"+file_name,
        Bucket=BUCKET_NAME,
        Key=file_name,
    )
    # create thumbnail
    _im = image.copy()
    thumbnail_name = 'thnl'+file_name
    image.thumbnail((100,100))
    image.save('data/'+thumbnail_name)
    # upload thumbnail to s3
    s3.upload_file(
        Filename="data/" + thumbnail_name,
        Bucket=BUCKET_NAME,
        Key=thumbnail_name,
    )

    # upload metadata to mysql db
    upload_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    s3_location = "/"
    original_size = str(_im.size)
    original_format = str(image.format)
    s3_th_location = "/"
    table = "myrdsimagestore"
    # print(upload_time, s3_location, original_size, original_format, s3_th_location)
    mysql.insert_into_table(table, upload_time,s3_location, original_size, original_format, s3_th_location)

def download_file(file_name):
    s3 = boto3.client("s3")
    # test image
    s3.download_file(
        Bucket=BUCKET_NAME,
        Key=file_name,
        Filename="data/downloaded_"+file_name
    )

def list_files_in_dir():
    os.chdir("data/")
    extensions = ["*.jpg", "*.jpeg", "*.png"]
    for i in extensions:
        for file in glob.glob(i):
            print(file)

def empty_bucket():
    # """
    # This function deletes all files in a folder from S3 bucket
    # :return: None
    # """
    # bucket_name = "amdjab-img-store-bucket"
    # s3_client = boto3.client("s3")
    # # First we list all files in folder
    # response = s3_client.list_objects_v2(Bucket=bucket_name, Prefix="/")
    # files_in_folder = response["Contents"]
    # files_to_delete = []
    # # We will create Key array to pass to delete_objects function
    # for f in files_in_folder:
    #     files_to_delete.append({"Key": f["Key"]})
    # # This will delete all files in a folder
    # response = s3_client.delete_objects(
    #     Bucket=bucket_name, Delete={"Objects": files_to_delete}
    # )
    # print(response)
    pass


if __name__ == "__main__":
    upload_file('koala.jpg')
    # download_file('koala.jpg')
    # list_files_in_dir()
    # empty_bucket()
