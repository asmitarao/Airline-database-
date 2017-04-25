<!DOCTYPE html>  
<html> 
<title></title>
<head>
</head>  

<body>
 <?php

    /* Attempt MySQL server connection. */
$link = mysqli_connect("localhost", "root", "", "airline" );
// Check connection

if($link === false){

    die("ERROR: Could not connect. " . mysqli_connect_error());
}
else{
	echo "yaaaayyy";
}
 

// Escape user inputs for security

$flight = mysqli_real_escape_string($link, $_POST['Flight_id']);

$days = mysqli_real_escape_string($link, $_POST['Working_days']);


 
echo "$flight";
echo "$days";
// attempt insert query execution

$sql = "INSERT INTO Flight(flight_id,Working_days ) VALUES ('$flight','$days' )";
if(mysqli_query($link, $sql)){

    echo "The values are inserted succesfully";

} else{

    echo "ERROR: Could not insert.  PLease try again" . mysqli_error($link);

}

 

// close connection

mysqli_close($link);

?>




<p></p>

<br><br>

<p>Click on the link provided to be redirected to the <a href="home.html">Home page</a> <br>Or the <a href="feedback.html">Feedback page</a> , if you wish to submit another feedback to us</p>

</body>
</html>
