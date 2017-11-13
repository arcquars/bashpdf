<?php
//if they DID upload a file...
$message="";
if($_FILES['file']['name'])
{
	//if no errors...
	if(!$_FILES['file']['error'])
	{
		//now is the time to modify the future file name and validate the file
		//echo $_FILES['file']['tmp_name'];
		//die();
		$new_file_name = strtolower($_FILES['file']['name']); //rename file
		//$new_file_name = "pp.pdf"; //rename file
		$valid_file = true;
		if($_FILES['file']['size'] > (1024000)) //can't be larger than 1 MB
		{
			$valid_file = false;
			$message = 'Oops!  Your file\'s size is to large.';
		}
		
		//if the file has passed the test
		if($valid_file)
		{
			$dir_pdf = dirname(__FILE__).'/uploads/'.$new_file_name;
			//move it to where we want it to be
			move_uploaded_file($_FILES['file']['tmp_name'], $dir_pdf);			
			$output = shell_exec("./pdf_gho.sh ".$dir_pdf);

			if(strcmp($output, 'false') == 0){
				$message = 'La tarea se realizo con exito!!';
			}else{
				$auxDir = dirname(__FILE__).'/outputA3.pdf';
				header('Content-Type: application/octet-stream');
				header("Content-Transfer-Encoding: Binary"); 
				header("Content-disposition: attachment; filename=\"" . basename($auxDir) . "\"");
				readfile($auxDir); // do the double-download-dance (dirty but worky)
			}
		}
	}
	//if there is an error...
	else
	{
		//set that to be the returned message
		$message = 'Ooops!  Your upload triggered the following error:  '.$_FILES['file']['error'];
	}
}

//you get the following information for each file:
//echo $_FILES['field_name']['name'];
//echo $_FILES['field_name']['size'];
//echo $_FILES['field_name']['type'];
//echo $_FILES['field_name']['tmp_name'];

echo $message;
?>
