import de.bezier.guido.*;
int SCREEN_WIDTH = 400; //draw width
int SCREEN_HEIGHT = 450; //draw height
int numRows;
int numCols;
int numBombs;
private Tile[][] buttons; //2d array of minesweeper buttons
private ArrayList <Tile> bombs; //ArrayList of just the minesweeper buttons that are mined
private Dashboard dash;
PFont myFont;
int status; //-1 is menu, 0 is new, 1 is in progress, 2 is loss, 3 is win

void setup ()
{
    status = -1;
    noStroke();
    size(400, 450); //window size
    textAlign(CENTER,CENTER);
    myFont = createFont("Bahnschrift", 10, true);
    textFont(myFont);
    Interactive.make( this );
    dash = new Dashboard();
}
public void initialize()
{
    buttons = new Tile[numRows][numCols];
    for (int i = 0; i < buttons.length; i++)
        for (int j = 0; j < buttons[i].length; j++)
            buttons[i][j] = new Tile(i, j);
    bombs = new ArrayList();
}
public void setBombs()
{
    bombs = new ArrayList(); 
    for (int i = 0; i < numBombs; i++){
        int row = (int)(Math.random() * numRows);
        int col = (int)(Math.random() * numCols);
        if (!bombs.contains(buttons[row][col]))
            bombs.add(buttons[row][col]);
        else
            i--;
    }
}

public void draw ()
{
    background(20, 20, 20);
    dash.draw();
    if (status != -1) {
        if(isWon()) {
            status = 3;
        }
        if (status == 2 || status == 3)
            dash.stopTimer();
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
