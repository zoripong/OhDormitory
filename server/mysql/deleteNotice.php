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
        $id = $_POST['id'];
        $type = $_POST['type'];

        $detail_table = "basic_notice";

        if($type == 1){
                $detail_table = "clean_notice";
        }else if($type == 2){
                $detail_table = "sleepout_notice";
        }

        $noticeSql = "DELETE FROM notice WHERE id=".$id;
        $noticeResult = mysqli_query($link, $noticeSql);
        if(!$noticeResult){
                echo "SQL문 처리중 에러 발생 : ";
                ehco mysqli_error($link);
        }

        $detailSql = "DELETE FROM ".$detail_table." WHERE id=".$id;
        $detailResult = mysqli_query($link, $noticeSql);

        if(!$detailResult){
                echo "SQL문 처리중 에러 발생 : ";
                ehco mysqli_error($link);
        }


mysqli_close($link);


?>
