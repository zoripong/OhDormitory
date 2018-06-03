<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT');
header("Access-Control-Allow-Headers: X-Requested-With, Content-Type");

$link=mysqli_connect("localhost","admin","admin@)!*", "ohdormitory" );
if (!$link)
{
    echo "MySQL 접속 에러 : ";
    echo mysqli_connect_error();
    exit();
}

mysqli_set_charset($link,"utf8");

$before_emirim_id = $_POST["before_emirim_id"];
$room_num = $_POST["room_num"];
$name = $_POST["name"];
$emirim_id = $_POST["emirim_id"];
$student_phone = $_POST["student_phone"];
$parent_phone = $_POST["parent_phone"];

if($before_emirim_id == $emirim_id){
        $strSQL = "UPDATE user SET room_num=".$room_num.", name='".$name."', student_phone='".$student_phone."', parent_phone='".$parent_phone."' WHERE emirim_$";
        $result=mysqli_query($link,$strSQL);

        if(!$result){

           echo "SQL문 처리중 에러 발생 : ";
            echo mysqli_error($link);
        }
}else{
        // 관련된 데이터 전부 삭제

        //alarm, user_score, wash_applying_user , sleepoout_record

        $table = array('user', 'alarm', 'user_score', 'wash_applying_user', 'sleepout_record');
        for($i = 0; $i < sizeof($table); $i++){
              $subSql = "DELETE FROM ".$table[$i]." WHERE emirim_id=".$before_emirim_id;
              $subResult = mysqli_query($link, $subSql);

              if(!$subResult){
                      echo "SQL문 처리중 에러 발생 : ";
                      echo mysqli_error($link);
                    }
                }
        
                $sql = "INSERT INTO user VALUES ('".$emirim_id."', 'alflarhkgkrrh', '".$name."', ".$room_num.", '".$student_phone."', '".$parent_phone."')";
                 $result=mysqli_query($link,$sql);
        
                if(!$result){
        
                   echo "SQL문 처리중 에러 발생 : ";
                    echo mysqli_error($link);
                }
        
        
        }
        
        
        
        
        }
        
        
        mysqli_close($link);
        
        
        
        ?>
        
        
