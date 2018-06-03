<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT');
header("Access-Control-Allow-Headers: X-Requested-With, Content-Type");
ini_set("allow_url_fopen", 1);

if(isset($_POST["submit"])){
    $link=mysqli_connect("localhost","admin","admin@)!*", "ohdormitory" );

    if (!$link)
    {
        echo "MySQL 접속 에러 : ";
        echo mysqli_connect_error();
        exit();
    }

    mysqli_set_charset($link,"utf8");
 
    echo $filename=$_FILES["file"]["name"];
    // $ext=substr($filename,strrpos($filename,"."),(strlen($filename)-strrpos($filename,".")));
 
    //we check,file must be have csv extention
    // if($ext=="csv")
    // {
    $file = fopen($filename, "r");
            while (($emapData = fgetcsv($file, 10000, ",")) !== FALSE)
            {
                $sql = "INSERT into tableName(name,email,address) values('$emapData[0]','$emapData[1]','$emapData[2]')";
                $result = mysqli_query($sql);
                if(!$result){
                    echo "error";
                }
            }
            fclose($file);
            echo "CSV File has been successfully Imported.";
    // }
    // else {
        // echo "Error: Please Upload only CSV File";
    // }
 
 
}else{
    echo "isset return false";
}
?>