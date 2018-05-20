<?php
    $host='54.203.113.95';//insert as yours
    $uname='admin';
    $pwd='admin@)!*';
    $db="ohdormitory";
 
    $conn = mysqli_connect($host, $uname, $pwd, $db); // Check connection

    if (mysqli_connect_errno()){
    
     echo "MySQL 연결 실패 : " . mysqli_connect_error();
    
    }
    
    $result = mysqli_query($conn,"SELECT * FROM user");
    
    
    
    
    
    
    
    while($row = mysqli_fetch_array($result)){
    
     echo "<no='" . $row['emirim_id'] . "' mdn='". $row['password'] . "' id='". $row['name'] . "'>\n";
     echo "<no='" . $row['room_num'] . "' mdn='". $row['parent_phone'] . "'>\n";
    
    }
    
    mysqli_close($conn);
    
    
?>

