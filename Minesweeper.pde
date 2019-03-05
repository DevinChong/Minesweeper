import de.bezier.guido.*;
int NUM_ROWS = 9;
int NUM_COLS = 9;
int NUM_BOMBS = 10;
private Tile[][] buttons; //2d array of minesweeper buttons
private ArrayList <Tile> bombs; //ArrayList of just the minesweeper buttons that are mined
private Dashboard dash;
PFont myFont;
int status; //0 is new, 1 is in progress, 2 is loss, 3 is win

void setup ()
{
    status = 0;
    noStroke();
    size(400, 450);
    textAlign(CENTER,CENTER);
    myFont = createFont("Bahnschrift", 10, true);
    textFont(myFont);
    Interactive.make( this );
    initialize();
}
public void initialize()
{
    dash = new Dashboard();
    buttons = new Tile[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < buttons.length; i++)
        for (int j = 0; j < buttons[i].length; j++)
            buttons[i][j] = new Tile(i, j);
    bombs = new ArrayList();
}
public void setBombs()
{
    bombs = new ArrayList(); 
    for (int i = 0; i < NUM_BOMBS; i++){
        int row = (int)(Math.random() * NUM_ROWS);
        int col = (int)(Math.random() * NUM_COLS);
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
    if(isWon()) {
        status = 3;
    }
    if (status == 2 || status == 3)
        dash.stopTimer();
}
public boolean isWon()
{
    for (int i = 0; i < buttons.length; i++)
        for (int j = 0; j < buttons[i].length; j++)
            if (!bombs.contains(buttons[i][j]) && !buttons[i][j].isClicked())
                return false;
    return true; 
}