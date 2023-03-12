$sevenzip	= '"C:\Program Files\7-Zip\7z.exe"'
$archive	= '"C:\temp space\archive.zip"'
$output_path 	= '"C:\temp space\deploy"'
exec { 'extract_archive.zip':
command => "${sevenzip} x ${archive} -o${output_path} -y"
creates => $output_path,
}
