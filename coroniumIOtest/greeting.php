<?php

  $in_data = json_decode(file_get_contents('php://input'));

  $greeting = 'Hello ' . $in_data->{"username"} . '!';

  $response = array("greeting" => $greeting);

  print(json_encode($response));

?>