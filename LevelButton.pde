public class LevelButton extends MSButton
{
    private float x,y, width, height;
    private String label4;
    private String label3;
    private String label2;
    private int level;

    public LevelButton(int lv)
    {
        level = lv;
        if (level == 1) {
            x = (SCREEN_WIDTH / 5) - 55;
            label4 = "10 bombs";
            label3 = "9 x 9";
            label2 = "BEGINNER";
        } else if (level == 2) {
            x = (SCREEN_WIDTH / 2) - 55;
            label4 = "40 bombs";
            label3 = "16 x 16";
            label2 = "INTERMEDIATE";
        } else if (level == 3) {
            x = 4 * (SCREEN_WIDTH / 5) - 55;
            label4 = "90 bombs";
            label3 = "24 x 24";
            label2 = "EXPERT";
        }
        y = (SCREEN_HEIGHT / 2) - 45;
        label = "";
        width = 110;
        height = 90;
        Interactive.add( this ); // register it with the manager
    }

    public void draw()
    {
        if (status == -1) {
            fill(75);
            rect(x + (width * 0.1), y + (width * 0.1), width * 0.9, height * 0.9, width / 10); 
            fill(255);
            textSize(30);
            text(label3,x+(width/2),y+(height/2));
            textSize(10);
            text(label2,x+(width/2),y+(height/4));
            text(label4,x+(width/2),y+3 * (height/4));
        }
    }

    public void mousePressed()
    {
        if (status == -1) {
            if (level == 1) {
                numRows = 9;
                numCols = 9;
                numBombs = 10;
            } else if (level == 2) {
                numRows = 16;
                numCols = 16;
                numBombs = 40;
            } else if (level == 3) {
                numRows = 20;
                numCols = 20;
                numBombs = 90;
            }
            status = 0;
            initialize();
        }
    }
}