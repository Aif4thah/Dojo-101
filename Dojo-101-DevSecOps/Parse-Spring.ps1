function Get-SpringArtefacts
{
    <#
    .SYNOPSIS
        Basic Srping code grabber

    .DESCRIPTION
        collect wsdl, xsd, mappers, parameters and security hotspots

    .PARAMETER source
        source folder

    .PARAMETER output
        output folder

    .OUTPUTS
        API mapping, wsdl

    .EXAMPLE
        Get-SpringArtefact -source .\Spring-project -output .\CShidori-results

    #>



    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string] $source,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string] $output   
    )




    begin
    {

        if( -not (test-path $output))
        {
            mkdir $output 
        }

        $endpointsPath = $output + "\endpoints.txt"
        $paramPath = $output + "\parametersNames.txt"
        $CshidoriWl = $output + "\fuzz.txt"
        $CshidoriPath = ".\CShidori.exe"
        $endpoints = $param = @()
        $parentheseEndpoints = $parentheseParam = $false

        write-host "[*] geting files..."
        $files = get-ChildItem -recurse -file -Path $source



    }
    Process
    {

        <# ***** EXTENSIONS ***** #>
        write-host "[*] interesting files extentions ?" 

        $files |ForEach-Object `
        {   
            $file = $_.FullName
            $name = $_.Name

            if($file -match 'wsdl$' -or $file -match 'dtd$' -or $file -match 'xsd$' -or $file -match 'p12$' -or $file -match 'jks$' -or $file -match 'cer$')
            { 
                $hash = (Get-FileHash -Algorithm SHA256 $file).Hash
                copy-item -Path $file -Destination "${output}\${hash}-$name"
                write-host ("[!] file grabbed : {0}" -f $file) -ForegroundColor Cyan
            }

        }




        <# ***** CODE REVIEW ***** #>
        write-host "[*] Performing code review"
        $id = $more = 0

        $files |ForEach-Object `
        {
            $file = $_.FullName

            if ( $id - $more -gt 100 )
            {
                read-host "press enter to continue"
                $more = $id
            }

            if($file -match '(\.java$)' -or $file -match '(\.properties$)' -or $file -match '(\.yml$)' )
            {   
                $content = Get-Content -path $file
                $content |ForEach-Object `
                {    
                    $line = $_

                    # find password
                    if ($line -match 'pass\w:*\s*(.+)' -or 
                    $line -match 'secret'
                    )
                    {
                        write-host ("[{0}] secret : {1} : {2}" -f $id,$file,$line) -ForegroundColor White
                        $id+=1
                    }

                    #non salted hash
                    if ($line -match '[A-Fa-f0-9]{32,64}'){
                        write-host ("[{0}] hash : {1} : {2}" -f $id,$file,$line) -ForegroundColor Yellow
                        $id+=1
                    }

                    #sql queries
                    if ( $line -match '@query' -or
                    $line -match 'drop ' -or
                    $line -match 'Query\(' -or
                    $line -match 'select ' -or
                    $line -match 'update ' -or
                    $line -match 'delete ' -or
                    $line -match 'insert ' -or
                    $line -match ' where ' -or
                    $line -match 'jdbc'
                    )
                    {
                        write-host ("[{0}] sql : {1} : {2}" -f $id,$file,$line) -ForegroundColor Blue
                        $id+=1
                    }

                    # Concat   (["'] ?[+.] )|([+.] ?["'])

                    if ( $line -match "([`"'] ?[+.] )|([+.] ?[`"'])"  )
                    {
                        write-host ("[{0}] Concat : {1} : {2}" -f $id,$file,$line) -ForegroundColor Cyan
                        $id+=1
                    }

                    # URI
                    if ( $line -match "(https?|ftp|file)://(.*)" -or
                    $line -match "@RequestBody" -or
                    $line -match "@ResponseBody" -or
                    $line -match "Header" -or
                    $line  -match "redirect"
                    )
                    {
                        write-host ("[{0}] External ressource : {1} : {2}" -f $id,$file,$line) -ForegroundColor Green
                        $id+=1
                    }

                    # Risky 
                    if ( $line -match ' eval\(' -or 
                    $line -match ' exec\(' -or
                    $line -match " system\(" -or
                    $line -match " cmd" -or
                    $line -match " runas" -or
                    $line -match " chmod" -or
                    $line -match " sudo" -or 
                    $line -match " StackTrace" -or
                    $line -match ' runtime' -or
                    $line -match 'Admin' -or
                    $line -match " buffer"
                    )
                    {
                        write-host ("[{0}] Risky : {1} : {2}" -f $id,$file,$line) -ForegroundColor Magenta
                        $id+=1
                    }

                    # Regexp
                    if ( $line -match ' regex' -or
                    $line -match ' pattern' -or
                    $line -match ' compile' -or
                    $line -match ' match' -or
                    $line -match ' replace'
                    )
                    {
                        write-host ("[{0}] Filters : {1} : {2}" -f $id,$file,$line) -ForegroundColor Gray
                        $id+=1
                    }
                    
                    #serialization
                    if ( $line -match 'Java.io' -or
                    $line -match 'serializ' -or
                    $line -match '.*readObject\(.*' -or
                    $line -match 'java.beans.XMLDecoder' -or
                    $line -match 'com.thoughtworks.xstream.XStream' -or
                    $line -match '.*\.fromXML\(.*\)' -or
                    $line -match 'com.esotericsoftware.kryo.io.Input' -or
                    $line -match '.readClassAndObject\(.*' -or
                    $line -match '.readObjectOrNull\(.*' -or
                    $line -match 'com.caucho.hessian.io' -or
                    $line -match 'com.caucho.burlap.io.BurlapInput' -or
                    $line -match 'com.caucho.burlap.io.BurlapOutput' -or
                    $line -match 'org.codehaus.castor' -or
                    $line -match 'Unmarshaller' -or
                    $line -match 'jsonToJava\(.*' -or
                    $line -match 'JsonObjectsToJava\/.*' -or
                    $line -match 'JsonReader' -or
                    $line -match 'ObjectMapper\(' -or
                    $line -match 'enableDefaultTyping\(\s*\)' -or
                    $line -match '@JsonTypeInfo\(' -or
                    $line -match 'readValue\(.*\,\s*Object\.class' -or
                    $line -match 'com.alibaba.fastjson.JSON' -or
                    $line -match 'JSON.parseObject' -or
                    $line -match 'com.owlike.genson.Genson' -or
                    $line -match 'useRuntimeType' -or
                    $line -match 'genson.deserialize' -or
                    $line -match 'org.red5.io' -or
                    $line -match 'deserialize\(.*\,\s*Object\.class' -or
                    $line -match '\.Yaml' -or
                    $line -match '\.load\(.*' -or
                    $line -match '\.loadType\(.*\,\s*Object\.class' -or
                    $line -match 'YamlReader' -or
                    $line -match 'com.esotericsoftware.yamlbeans'
                    )
                    {
                        write-host ("[{0}] Serialization : {1} : {2}" -f $id,$file,$line) -ForegroundColor DarkYellow
                        $id+=1
                    }

                    # Spring Security

                    if ( $line -match 'WebSecurity' -or
                    $line -match 'HttpSecurity' -or
                    $line -match 'SecurityConfig' 
                    )
                    {
                        write-host ("[{0}] Spring Security : {1} : {2}" -f $id,$file,$line) -ForegroundColor DarkGreen
                        $id+=1
                    }


                    # Input / Output
                    if ( $line -match 'InputStream' -or 
                    $line -match "StreamTokenizer" -or
                    $line -match "Random" -or
                    $line -match "File " -or
                    $line -match "AsStream" -or 
                    $line -match "rename" -or
                    $line -match 'writer' -or
                    $line -match 'Mkdir')
                    {
                        write-host ("[{0}] IO : {1} : {2}" -f $id,$file,$line) -ForegroundColor black -BackgroundColor Gray
                        $id+=1
                    }

                    # Session
                    if ( $line -match 'validate' -or 
                    $line -match "session"
                    )
                    {
                        write-host ("[{0}] IO : {1} : {2}" -f $id,$file,$line) -ForegroundColor black -BackgroundColor Cyan
                        $id+=1
                    }

                }
            }

        }

    }
    end
    {

        <# ***** WORDLISTS ***** #>

        write-host "[*] Collecting API Mappers"
        $files |ForEach-Object `
        {
            $file = $_.FullName
            if($file -match '(\.java$)')
            {
                $content = Get-Content -path "$file"
                $content |ForEach-Object `
                {    
                    $line = $_
                 
                    if( ($line -match '@\w{3,8}mapp\w*\(.*\)' -or $line -match 'getAsStream\(' ) -and $line -match '"(.*)"'  )
                    { 
                        #($line -match "@RequestMapping" -or $line -match "@GetMapping" -or $line -match '@PostMapping' -or $line -match '@PutMapping' -or $line -match '@DeleteMapping') -and $line -match '"(.*)"')
                        $endpoints += get-QuotedParam -value ($Matches[0].split('"'))                  
                    }

                    elseif(($line -match '@RequestParam' -or $line -match '@PathVariables') -and $line -match '"(.*)"'  )
                    { 
                        $param += get-QuotedParam -value ($Matches[0].split('"'))                       
                    }
                    elseif($line -match '@Param ')
                    { 
                        $param +=  $line.split(" ")[-1].trim("'`". ")                      
                    }

                    <# case:
                    @RequestMapping(
                        value = "/path",
                        method = RequestMethod.DELETE,
                        produces = MediaType.APPLICATION_JSON_VALUE)                    
                    #>
                    if( $line -match '@\w{3,8}mapp\w*\(' -and $line -notmatch '\)' )
                    {
                        $parentheseEndpoints = $true
                    }
                    elseif( ( $line -match '@RequestParam' -or $line -match '@PathVariables' ) -and $line -notmatch '\)')
                    {
                        $parentheseParam = $true
                    }
                    elseif( $line -match '\)' )
                    {
                        $parentheseEndpoints = $parentheseParam = $false
                    }
                    if($parentheseEndpoints){
                        if($line -match '"(.*)"')
                        {
                            $endpoints += get-QuotedParam -value ($Matches[0].split('"'))  
                        }
                    } 
                    if($parentheseParam){
                        if($line -match '"(.*)"')
                        {
                            $param += get-QuotedParam -value ($Matches[0].split('"'))    
                        }
                    }              
                        
                }

            }

        }

        write-host "[*] Sorting results..." 
        $endpoints = $endpoints |Select-Object -Unique 
        $param = $param |Select-Object -Unique 

        write-host "[*] Generating Wordlists..."
        $endpoints  >> $endpointsPath
        $param >> $paramPath

       if (test-path $CshidoriPath)
       {
            write-host "[*] Generating Fuzzing lists" -ForegroundColor Yellow
        
            $badchars = Invoke-expression("$CshidoriPath -m bc")

            $badchars >> $paramPath

            get-content $endpointsPath |ForEach-Object `
            {
                $line = $_
                if($line -match "{\w*}")
                {
                    $badchars|ForEach-Object `
                    {
                        $line -replace "{\w*}", $_ >> $CshidoriWl
                    }               
                }
            }

            write-host "[*] Sorting fuzzing lists..." -ForegroundColor Yellow
    
            $tmp = Get-Content $CshidoriWl |Select-Object -Unique ; $tmp > $CshidoriWl
            $tmp = Get-Content $endpointsPath |Select-Object -Unique ; $tmp > $endpointsPath
            $tmp = Get-Content $paramPath |Select-Object -Unique ; $tmp > $paramPath
        }


        write-host "[*] end." -ForegroundColor Yellow

    }

}

function remove-slash($in){
    if($in[0] -eq '/')
    { 
        $in = $in.Substring(1)
    }
    return $in   
}



function get-QuotedParam($values){
 
    $dico = @()
    for($i=0; $i -lt $values.length; $i++)
    {
        if(($i % 2) -eq 1)
        { 
            $dico += remove-slash($values[$i])
        }
    } 
    return $dico
}
