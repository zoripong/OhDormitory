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

        $emirim_id = $_POST['emirim_id'];
        $date = $_POST['date'];
        $score_id = $_POST['score_id'];

        $strSQL = "INSERT INTO user_score VALUES(null, '".$emirim_id."', '".$da$
        $result=mysqli_query($link,$strSQL);

        $title = $_POST['title'];
        $type = $_POST['type'];
        $w_time = $_POST['w_time'];
        $d_time = $_POST['d_time'];

        //TODO insert into notice;
        $insertNotice = "INSERT INTO notice VALUES (NULL,'".$title."', '".$type."', '".$w_time."', '".$d_time."')";
        $insertNoticeResult = mysqli_query($link, $insertNotice);

        if(!$insertNoticeResult){
                echo "SQL문 처리중 에러 발생 : ";
                echo mysqli_error($link);
        }

        $selectNotice = "SELECT notice_id FROM notice WHERE title='".$title."' and type=".$type." and w_time = '".$w_time."' and d_time = '".$d_time."'";

        $selectNoticeResult=mysqli_query($link,$selectNotice);

        $notice_id = -1;

        if($selectNoticeResult){
                while($row=mysqli_fetch_array($result)){
                    $notice_id = $row[0];
                }
        }else{
                echo "SQL문 처리중 에러 발생 : ";
                 echo mysqli_error($link);
        }


        if($notice_id == -1){
                 echo "SQL문 처리중 에러 발생 : $notice_id = -1";
        }else{
                if($type == 1){
                // basic
                        $content = $_POST['content'];
                        $sql = "INSERT INTO basic_notice VALUES (".$notice_id.",'".$content."')";
                        $result = mysqli_query($link, $sql);

                        if(!$result){
                                echo "SQL문 처리중 에러 발생 : ";
                                echo mysqli_error($link);
                        }

                }else if($type == 2){

                // clean
                        //TODO : array
                        $data = json_decode(stripslashes($_POST['clean_area']));
                        $index = 0;
                        foreach($data as $d){
                                $sql = "INSERT INTO clean_notice VALUES (".$notice_id.", ".$index.", ".$d.")";
                                $index = $index + 1;
                                $result = mysqli_query($link, $sql);

                                if(!$result){
                                        echo "SQL문 처리중 에러 발생 : ";
                                        echo mysqli_error($link);
                                }

                        }


                }else if($type == 3){
                // sleep out
                $application_deadline = $_POST['sleep_d_time'];
                $sleep_w_time = $_POST['sleep_w_time'];
                $sleep_d_time = $_POST['sleep_d_time'];
                $send = 0;
                $sql = "INSERT INTO sleepout_notice VALUES (".$notice_id.",'".$application_deadline."', '".$sleep_w_time."', '".$sleep_d_time."', ".$send.")";


                $result = mysqli_query($link, $sql);

                if(!$result){
                        echo "SQL문 처리중 에러 발생 : ";
                        echo mysqli_error($link);
                }
        }
}
mysqli_close($link);
