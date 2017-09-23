//
//  ViewController.m
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/10.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "ViewController.h"
#import <FMDatabase.h>
#import <FMDatabaseAdditions.h>
#import "Person.h"

@interface ViewController ()

@property (strong, nonatomic) FMDatabase *db;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSMutableArray *studentsArr;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF2;

@end

@implementation ViewController


- (NSMutableArray *)studentsArr {
    
    if (!_studentsArr) {
        
        _studentsArr = [NSMutableArray new];
    }
    return _studentsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTapGRToView];
}

- (IBAction)createDBAction:(id)sender {
    
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    _db = [FMDatabase databaseWithPath:fileName];
    
    if ([_db open])
    {
        if (![_db tableExists:@"t_student"]) {
            
            BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
            if (result)
            {
                NSLog(@"创建表成功");
            }
        }
    }
    
    [self autoPrint];
}

- (IBAction)clearDBAction:(id)sender {
    
    [_db executeUpdate:@"delete from t_student"];
}

- (IBAction)insert:(id)sender {
    
    NSString *name = nil;
    NSString *age = nil;
    
    if ([_nameTF.text length] > 0 && [_ageTF.text length] > 0) {
        
        name = _nameTF.text;
        age = _ageTF.text;
    }
    else {
        
        
    }
    
//    int age = 42;
//    NSString *name = @"艾斯利";
    
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?,?);",name, age];
    
    //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
//    [self.db executeUpdateWithForamat:@"insert into t_student (name,age) values (%@,%i);",name,age];
    
    //3.参数是数组的使用方式
//    [self.db executeUpdate:@"INSERT INTO
//     t_student(name,age) VALUES  (?,?);"withArgumentsInArray:@[name,@(age                 )]];
    
    [self autoPrint];
}

- (IBAction)delete:(id)sender {
    
    //1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）
    
    NSString *name = _nameTF2.text;
    [self.db executeUpdate:@"delete from t_student where name = ?;", name];
    
    [self autoPrint];
}

- (IBAction)update:(id)sender {
    
    NSString *newName = @"赫伯特";
    NSString *oldName = @"艾斯利";
    
    //修改学生的名字
    [self.db executeUpdate:@"update t_student set name = ? where name = ?",newName,oldName];
    
    [self autoPrint];
}

- (void)autoPrint {
    
    if (self.switchBtn.isOn) {
        
        [self getDataFromDBAndPrint];
    }
}

- (void)getDataFromDBAndPrint {
    
    [self.studentsArr removeAllObjects];
    
    NSString *sql = [NSString stringWithFormat:@"select * from t_student"];
    FMResultSet *rs = [self.db executeQuery:sql];
    
    while (rs.next) {
        
        Person *ret = [Person new];
        ret.name = [rs stringForColumn:@"name"];
        ret.age = [rs stringForColumn:@"age"];
        
        [_studentsArr addObject:ret];
    }
    
    [rs close];
    
    _textView.text = [NSString stringWithFormat:@"DataBase:\n%@", _studentsArr];
}

#pragma mark - Tap Gesture
- (void)addTapGRToView {
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] init];
    [tapGR addTarget:self action:@selector(resignAllTextFieldsResponse)];
    [self.view addGestureRecognizer:tapGR];
}

- (void)resignAllTextFieldsResponse {
    
    [_ageTF resignFirstResponder];
    [_nameTF resignFirstResponder];
    [_nameTF2 resignFirstResponder];
}




@end
