<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of GCM
 *
 * @author Ravi Tamada
 */
class PushiPhone {

    //put your code here
    // constructor
    function __construct() {
        
    }

    /**
     * Sending Push Notification
     */
    public function send_notification($registatoin_ids, $message) {
        
        echo "hellooo i ma here";
        // include config
        include_once './config.php';

       /* // Set POST variables
      //  $url = 'https://android.googleapis.com/gcm/send';

        $fields = array(
            'registration_ids' => $registatoin_ids,
            'data' => $message,
        );

        $headers = array(
            'Authorization: key=' . GOOGLE_API_KEY,
            'Content-Type: application/json'
        );
        // Open connection
        $ch = curl_init();

        // Set the url, number of POST vars, POST data
        curl_setopt($ch, CURLOPT_URL, $url);

        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        // Disabling SSL Certificate support temporarly
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));

        // Execute post
        $result = curl_exec($ch);
        if ($result === FALSE) {
            die('Curl failed: ' . curl_error($ch));
        }

        // Close connection
        curl_close($ch);
        echo $result;*/
        
        
        // Put your device token here (without spaces):
        $deviceToken ='96ff8e4e834708e8240ec4c93acd64bc2a890932e50892fc7b61586518dfa169';
        
        // Put your private key's passphrase here:
        $passphrase = 'admin';
        
        // Put your alert message here:
       
        
        ////////////////////////////////////////////////////////////////////////////////
        
        $ctx = stream_context_create();
        stream_context_set_option($ctx, 'ssl', 'local_cert', 'MyPushApp.pem');
        stream_context_set_option($ctx, 'ssl', 'admin', $passphrase);
        
        // Open a connection to the APNS server
        $fp = stream_socket_client(
                                   'ssl://gateway.sandbox.push.apple.com:2195', $err,
                                   $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);
        
        if (!$fp)
            exit("Failed to connect: $err $errstr" . PHP_EOL);
        
        echo 'Connected to APNS' . PHP_EOL;
        
        // Create the payload body
        $body['aps'] = array(
                             'alert' => $message,
                             'sound' => 'default'
                             );
        
        // Encode the payload as JSON
        $payload = json_encode($body);
        
        // Build the binary notification
        $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
        
        // Send it to the server
        $result = fwrite($fp, $msg, strlen($msg));
        
        if (!$result)
            echo 'Message not delivered' . PHP_EOL;
        else
            echo 'Message successfully delivered' . PHP_EOL;
        
        // Close the connection to the server
        fclose($fp);

    }

}

?>
