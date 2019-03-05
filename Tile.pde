public class Tile extends MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public Tile ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
   
    public void click()
    {
        clicked = true;
    }
    // called by manager
    
    public void mousePressed () 
    {  
        if (status == 0) {
            if (mouseButton == LEFT) {
                do {
                    setBombs();
                } while (countBombs(r, c) != 0);
                status = 1;
                dash.startTimer();
            }
            for (int i = r - 1; i < r + 2; i++)
                for (int j = c - 1; j < c + 2; j++)
                    if (isValid(i, j) && !buttons[i][j].clicked && !(i == r && j == c))
                        buttons[i][j].mousePressed();
        }
        if (status == 1) {
            if (marked) {
                label = "";
                marked = !marked;
            } else if(mouseButton == RIGHT && !clicked) {
                label = "🚩";
                marked = !marked;
            } else if (mouseButton == LEFT && !marked) {
                clicked = true;
                if (bombs.contains(this)) {
                    label = "💥";
                    for (int i = 0; i < buttons.length; i++)
                        for (int j = 0; j < buttons[i].length; j++)
                            if (!buttons[i][j].clicked && bombs.contains(buttons[i][j])) {
                                if (buttons[i][j].isMarked())
                                    buttons[i][j].mousePressed();
                                buttons[i][j].mousePressed();
                            }
                    status = 2;
                } else if (countBombs(r, c) != 0)
                    label = "" + countBombs(r, c);
                else {
                    for (int i = r - 1; i < r + 2; i++)
                        for (int j = c - 1; j < c + 2; j++)
                            if (isValid(i, j) && !buttons[i][j].clicked && !(i == r && j == c))
                                buttons[i][j].mousePressed();
                }
            }
        }
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    public void draw() 
    {    
        if (marked) //flag
            fill(220, 195, 35);
        else if( clicked && bombs.contains(this) ) //bomb
            fill(200, 25, 15);
        else if( clicked) //uncovered
            fill(200);
        else //covered
            fill(50, 150, 200);
        noStroke();
        rect(x + (width * 0.1), y + (width * 0.1), width * 0.9, height * 0.9, width / 10); //draws button
        
        //draws label
        if (marked || clicked) {
            textSize(width * 0.75);
            if (label.equals("1"))
                fill(0, 0, 128);
            else if (label.equals("2"))
                fill(0, 128, 0);
            else if (label.equals("3"))
                fill(188, 0, 0);
            else if (label.equals("4"))
                fill(128, 44, 24);
            else if (label.equals("5"))
                fill(128, 0, 0);
            else if (label.equals("6"))
                fill(0, 128, 128);
            else if (label.equals("7"))
                fill(0, 0, 0);
            else if (label.equals("8"))
                fill(128, 128, 128);
            else if (label.equals("💥") || label.equals("🚩")) {
                textSize(width * 0.5);
                fill(0, 0, 0);
            }
            text(label,x+(width/2),y+(height/2));
            if (status == 1)
                if (mousePressed)
                    dash.setLabel("😮");
                else
                    dash.setLabel("🙂");
        }
    }
    public boolean isValid(int r, int c)
    {
        if (r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row, col)) {
            for (int i = row - 1; i < row + 2; i++)
                for (int j = col - 1; j < col + 2; j++)
                    if (isValid(i, j) && bombs.contains(buttons[i][j]))
                        numBombs++;
        }
        return numBombs;
    }
}
    
    
