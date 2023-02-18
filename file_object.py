class FileObject:
    def __init__(self, upload_time, s3_location, s3_th_location, size, format):
        self.upload_time = upload_time
        self.s3_location = s3_location
        self.s3_th_location = s3_th_location
        self.size = size
        self.format = format

    def print_object(self):
        print("hi")
