public class Dashboard
{
    private MSButton face;
    private MSButton beginner;
    private MSButton intermediate;
    private MSButton expert;
    private int initMilli;
    private int elapMilli;
    private boolean timerRunning;
    private int flagsLeft;
    private int minutes, seconds;
    private String secondsString;

    public Dashboard()
    {
        flagsLeft = numBombs;
        face = new FaceButton();
        beginner = new LevelButton(1);
        intermediate = new LevelButton(2);
        expert = new LevelButton(3);
        secondsString = new String("00");
    }

    public void startTimer()
    {
        timerRunning = true;
        initMilli = millis();
    }

    public void stopTimer()
    {
        timerRunning = false;
    }

    public void draw() {
        if (status == -1) {
            textSize(20);
            text("select difficulty", SCREEN_WIDTH / 2, SCREEN_HEIGHT - 110);
        } else {
            flagsLeft = numBombs - countMarked();
            if (timerRunning) {
                elapMilli = millis() - initMilli;
                minutes = elapMilli / 60000;
                seconds = (elapMilli % 60000) / 1000;
                secondsString = "";
                if (seconds < 10)
                    secondsString += "0";
                secondsString += (int)seconds;
            }
            fill(45, 45, 45);
            rect(2, height - 47.5, width - 4, 45, 5); 
            fill(255);
            textSize(25);
            text("🚩 " + flagsLeft, (SCREEN_WIDTH / 4) - 20, SCREEN_HEIGHT - 26.5);
            text("⏱ " + (int)minutes + ":" + secondsString, (SCREEN_WIDTH * 3 / 4) + 20, SCREEN_HEIGHT - 26.5);
            textSize(15);
            if (status == 1) {
                if (mousePressed)
                    face.setLabel("😮");
                else
                    face.setLabel("🙂");
            } else if (status == 2)
                    face.setLabel("😖");
            else if (status == 3)
                    face.setLabel("😎");
        }
    }

    public int countMarked() {
        int result = 0;
        for (int i = 0; i < buttons.length; i++)
            for (int j = 0; j < buttons[i].length; j++)
                if (buttons[i][j].isMarked())
                    result++;
        return result;
    }
}