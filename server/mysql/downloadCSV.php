<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT');
header("Access-Control-Allow-Headers: X-Requested-With, Content-Type");

$con=mysqli_connect("localhost","admin","admin@)!*", "ohdormitory" );

if (!$con)
{
    echo "MySQL 접속 에러 : ";
    echo mysqli_connect_error();
    exit();
}

$query = "SELECT * FROM user";
if (!$result = mysqli_query($con, $query)) {
    exit(mysqli_error($con));
}

$users = array();
if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $users[] = $row;
    }
}

header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename=Users.csv');
$output = fopen('php://output', 'w');
fputcsv($output, array('emirim_id', 'password', 'name', 'room_num', 'student_phone', 'parent_phone'));

if (count($users) > 0) {
    foreach ($users as $row) {
        $row[4] = "0"+$row[4];
        fputcsv($output, $row);
    }
}



?>
