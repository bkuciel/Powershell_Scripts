function Remove-SpecialCharacters($string) {
    $HashLower = @{
        ą = 'a'
        ę = 'e'
        ó = 'o'
        ł = 'l'
        ż = 'z'
        ź = 'z'
        ć = 'c'
        ń = 'n'
        ś = 's'
    } 
    $HashUpper = @{
        Ą = 'A'
        Ę = 'E'
        Ó = 'O'
        Ł = 'L'
        Ż = 'Z'
        Ź = 'Z'
        Ć = 'C'
        Ń = 'N'
        Ś = 'S'
    }
    
    Foreach ($key in $HashLower.Keys)
    {
        $string = $string.Replace($key, $HashLower.$key)
    }
    Foreach($key in $HashUpper.Keys)
    {
        $string = $string.Replace($key, $HashUpper.$key)
    }
    return $string
}