import de.bezier.guido.*;
int NUM_ROWS = 9;
int NUM_COLS = 9;
int NUM_BOMBS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 500);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < buttons.length; i++)
        for (int j = 0; j < buttons[i].length; j++)
            buttons[i][j] = new MSButton(i, j);
    setBombs();
}
public void setBombs()
{
    for (int i = 0; i < NUM_BOMBS; i++){
        int row = (int)(Math.random() * NUM_ROWS);
        int col = (int)(Math.random() * NUM_COLS);
        if (!bombs.contains(buttons[row][col])){
            bombs.add(buttons[row][col]);
            println(row + ", " + col);
        }
        else
            i--;
    }
}

public void draw ()
{
    background(0);
    if(isWon())
        println("WON");
        displayWinningMessage();
}
public boolean isWon()
{
    boolean result = true;
    for (int i = 0; i < buttons.length; i++)
        for (int j = 0; j < buttons[i].length; j++)
            if (!buttons[i][j].isClicked())
                if (bombs.contains(buttons[i][j]))
                    result = false;
    return result; 
}
public void displayLosingMessage()
{
    text("Better Luck Next Time!", 0, 0);
}
public void displayWinningMessage()
{
    text("Congratulations!", 0, 0);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
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
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT) {
            marked = !marked;
        if (!marked)
            clicked = false;
        } else if (bombs.contains(this))
            displayLosingMessage();
        else if (countBombs(r, c) != 0)
            label = "" + countBombs(r, c);
        else {
            for (int i = r - 1; i < r + 2; i++)
                for (int j = c - 1; j < c + 2; j++)
                    if (isValid(i, j) && !buttons[i][j].clicked && !(i == r && j == c))
                        buttons[i][j].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x + (width * 0.1), y + (height * 0.1), width * 0.9, height * 0.9, width / 10);
        fill(0);
        textSize(width * 0.75);
        textAlign(CENTER, CENTER);
        text(label,x+width/2,y+(height/2));
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
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
