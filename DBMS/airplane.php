<!DOCTYPE html>
<html>
<head>
<style>
.mySlides {display:none; height: 500px;
    width: 1350px;}
div.transbox {
  margin: 30px;
  background-color: #ffffff;
  border: 1px solid black;
  opacity: 0.6;
  filter: alpha(opacity=60); /* For IE8 and earlier */
}

div.transbox p {
  margin: 5%;
  font-weight: bold;
  color: #000000;
}
div.hea{ text-align:center; color: #74116E; }
div.button{ color: #74116E; padding-left: 600px;  }
</style>
</head>
<body>
<div class="hea">
<h1>Qatar Airways</h1>

</div>
<div class="button" >
<form name="chat" action="fligh.php" id="a1" method="POST">
<input type="submit" value="flight details">
</form>
</div>
<img  class="mySlides" src="q1.jpg">
<img   class="mySlides" src="q3.jpg">
<img  class="mySlides" src="q4.jpg">
<!--<img class="mySlides" src="img_forest.jpg">-->

<div id="result_table">

</div>

<script>
var s = document.getElementById("a1")
s.onsubmit = sub;
function sub()
    {
        return a;
    }

var slideIndex = 0;
carousel();

function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    for (i = 0; i < x.length; i++) {
      x[i].style.display = "none"; 
    }
    slideIndex++;
    if (slideIndex > x.length) {slideIndex = 1} 
    x[slideIndex-1].style.display = "block"; 
    setTimeout(carousel, 2000); // Change image every 2 seconds
}
</script>
<?php


$con=mysqli_connect("localhost","root","","airline");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$result = mysqli_query($con,"SELECT * FROM airplane");

echo "<table border='1'>
<tr >
<th>Airplane_id</th>
<th>total_no_of seats</th>
<th>airplane_type</th>
</tr>";

while($row = mysqli_fetch_array($result))
  {
  echo "<tr>";
  echo "<td>" . $row[0] . "</td>";
  echo "<td>" . $row[1] . "</td>";
  echo "<td>" . $row[2]. "</td>";
  echo "</tr>";
  }
echo "</table>";

mysqli_close($con);

//Output results
?>
</body>
</html>

