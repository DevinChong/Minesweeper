public class MSButton
{
    private float x,y, width, height;
    private String label;

    public MSButton ()
    {

    }

    public MSButton (int xx, int yy)
    {
        label = "";
        x = xx;
        y = yy;
        width = 40;
        height = 40;
        Interactive.add( this ); // register it with the manager
    }
    
    public void mousePressed () 
    {
        //setup();
        status = 0;
        initialize();
    }

    public void draw () 
    {    
        fill(75);
        rect(x + (width * 0.1), y + (width * 0.1), width * 0.9, height * 0.9, width / 10); 
        textSize(30);
        fill(255);
        text(label,x+(width/2),y+(height/2));
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }

}