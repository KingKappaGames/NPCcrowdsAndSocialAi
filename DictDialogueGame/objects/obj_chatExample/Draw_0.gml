var _x = x;
var _y = y;

if (ChatterboxIsStopped(chatterbox))
{
    //If we're stopped then show that
    draw_text(_x, _y, "(Chatterbox stopped)");
}
else
{
    //Draw all content
    var _i = 0;
    repeat(ChatterboxGetContentCount(chatterbox))
    {
        var _string = ChatterboxGetContent(chatterbox, _i);
        draw_text(_x, _y, _string);
        _y += string_height(_string);
        ++_i;
    }
    
    _y += 30; //Bit of spacing...

    if (ChatterboxIsWaiting(chatterbox))
    {
        //If we're in a "waiting" state then prompt the user for basic input
        draw_text(_x, _y, "(Press Space)");
    }
    else
    {
        //Draw all options
        var _i = 0;
        repeat(ChatterboxGetOptionCount(chatterbox))
        {
            var _string = ChatterboxGetOption(chatterbox, _i);
            draw_text(_x, _y, string(_i+1) + ") " + _string);
            _y += string_height(_string);
            ++_i;
        }
    }
}