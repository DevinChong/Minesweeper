import de.bezier.guido.*;
int NUM_ROWS = 9;
int NUM_COLS = 9;
int NUM_BOMBS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList(); ; //ArrayList of just the minesweeper buttons that are mined
PFont myFont;
int status; //0 is new, 1 is in progress, 2 is loss, 3 is win

void setup ()
{
    status = 0;
    size(400, 500);
    textAlign(CENTER,CENTER);
    
    myFont = createFont("Bahnschrift", 10, true);
    textFont(myFont);
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < buttons.length; i++)
        for (int j = 0; j < buttons[i].length; j++)
            buttons[i][j] = new MSButton(i, j);
}
public void setBombs()
{
    bombs = new ArrayList(); 
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
    background(20, 20, 20);
    if(isWon()) {
        println("WON");
        displayWinningMessage();
    }
}
public boolean isWon()
{
    for (int i = 0; i < buttons.length; i++)
        for (int j = 0; j < buttons[i].length; j++)
            if (!bombs.contains(buttons[i][j]) && !buttons[i][j].isClicked())
                return false;
    return true; 
}
public void displayLosingMessage()
{
    status = 2;
    fill(255);
    text("Better Luck Next Time!", width / 2, height - 20);
}
public void displayWinningMessage()
{
    status = 3;
    fill(255);
    text("Congratulations!", width / 2, height - 20);
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
        if (status == 0) {
            do {
                setBombs();
            } while (countBombs(r, c) != 0);
            status = 1;
        }
        if (mouseButton == RIGHT && !clicked) {
            marked = !marked;
            label = "🚩";
        } else if (mouseButton == LEFT && !marked) {
            clicked = true;
            if (bombs.contains(this)) {
                label = "💥";
                displayLosingMessage();
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
    public void draw () 
    {    
        if (marked) //flag
            fill(200, 175, 15);
        else if( clicked && bombs.contains(this) ) //bomb
            fill(200, 25, 15);
        else if( clicked) //uncovered
            fill(200);
        else //covered
            fill(100);
        noStroke();
        rect(x + (width * 0.1), y + (width * 0.1), width * 0.9, height * 0.9, width / 10); //draws button
        
        //draws label
        if (marked || clicked) {
            textSize(width * 0.75);
            textAlign(CENTER, CENTER);
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
            else if (label.equals("💥") || label.equals("🚩"))
                fill(0, 0, 0);
            text(label,x+(width/2),y+(height/2));
        }
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
