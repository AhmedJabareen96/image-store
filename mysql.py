import pymysql
import file_object as fo

# in external file
# hostname = 
# user = 
# password = 

my_db = pymysql.connect(host=hostname, user= user,password= password)
cursor = my_db.cursor()

def connect():
    cursor.execute("select version()")
    data = cursor.fetchone()
    #  print(data)


def create_data_base(db_name):
    sql = "create database "+db_name
    cursor.execute(sql)
    cursor.connection.commit()


def create_table(table_name):
    sql = '''use test1'''
    cursor.execute(sql)
    sql = '''
    create table '''+table_name+'''(
    id int NOT NULL AUTO_INCREMENT,
    update_time_stamp varchar(30),
    original_image_location_s3 varchar(10),
    original_s3_th_location varchar(10),
    original_image_size varchar(30),
    original_image_format varchar(10),
    primary key (id)
    )
    '''
    cursor.execute(sql)
    my_db.commit()

def show_tables():
    sql = '''use test1'''
    cursor.execute(sql)
    sql = '''show tables'''
    cursor.execute(sql)
    tables = cursor.fetchall()
    # print("tables show here:")
    print(tables)

def insert_into_table(my_table, ut, s3_loc, or_size, or_form, s3_th_loc):
    sql = ''' use test1 '''
    cursor.execute(sql)
    sql = """
    insert into `myrdsimagestore` (update_time_stamp, original_image_location_s3, original_s3_th_location, original_image_size,
                                      original_image_format)
    values (%s, %s, %s, %s, %s)
     """
    cursor.execute(sql, (ut, s3_loc, or_size, or_form, s3_th_loc))
    my_db.commit()


def delete_from_table(id):
    sql = '''
    use test1
    '''
    cursor.execute(sql)
    sql = '''
    DELETE FROM `movies` WHERE `movie_id` = 18;
    '''
    cursor.execute(sql)
    my_db.commit()
def delete_table():
    sql = ''' use test1'''
    cursor.execute(sql)
    sql = '''
    DROP TABLE myrdsimagestore
    '''
    cursor.execute(sql)
    my_db.commit()

def show_databases():
    sql = ''' use test1'''
    cursor.execute(sql)
    sql = ''' show databases '''
    cursor.execute(sql)
    print(cursor.fetchall())

# if __name__ == "__main__":
    # create_data_base("asdf")
    # create_table('myrdsimagestore')
    # show_tables()
    # insert_into_table("myrdsimagestore","a", "a", "A", "a", "a")
    # delete_table()
    # show_databases()