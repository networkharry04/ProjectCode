<?php
    $msg="<Your notification message>";
    $pushToken= "<your captured hex push token>";
    $pushToken=pack("H*",$pushToken);
    
    send_apns($pushToken,$msg,1,'');
    
    function send_apns($token,$message,$badge,$sound) {
        // Construct the notification payload
        $body = array();
        $body['aps'] = array('alert' => $message);
        if ($badge) $body['aps']['badge'] = $badge;
        if ($sound) $body['aps']['sound'] = $sound;
        
        $ctx = stream_context_create();
        stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
        stream_context_set_option ($ctx, 'ssl', 'passphrase', '<password>');
        $fp = stream_socket_client('ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
        // for production change the server to ssl://gateway.push.apple.com:2195
        if (!$fp) {
            print "Failed to connect $err $errstr\n";
            return -1;
        }
        
        $payload = json_encode($body);
        $msg = chr(0) . pack("n",32) . $token . pack("n",strlen($payload)) . $payload;
        fwrite($fp, $msg);
        fclose($fp);
        
        return 0;
    }
    ?>