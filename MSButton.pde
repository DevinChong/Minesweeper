abstract class MSButton
{
    protected float x,y, width, height;
    protected String label;
    
    abstract public void mousePressed ();

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

    public String getLabel() {
        return label;
    }
}