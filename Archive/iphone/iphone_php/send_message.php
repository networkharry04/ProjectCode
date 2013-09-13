<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
if (isset($_GET["regId"]) && isset($_GET["message"])) {
    $regId = $_GET["regId"];
    $message = $_GET["message"];
    
    include_once './PushiPhone.php';
    
    
    $iosPush= new PushiPhone();

    $registatoin_ids = array($regId);
    $array = array(
                   "id" => '1234',
                   "store" => "Nike",
                   "txt" => "this is demo test",
                   "msg"=> $message
                   );
    $message = array("result" => $array);

    $result = $iosPush->send_notification($registatoin_ids, $message);

    echo $result;
}
?>
