<?php

if (isset($_POST['login']) && !empty($_POST['username']) 
               && !empty($_POST['password'])) {
				
               if ($_POST['username'] == 'walnka' && 
                  $_POST['password'] == '1234') {
                  $_SESSION['valid'] = true;
                  $_SESSION['timeout'] = time();
                  $_SESSION['username'] = 'walnka';
                  
                  echo 'You have entered valid username and password';
               }
               else {
                  $msg = 'Wrong username or password';
               }
            }


?>