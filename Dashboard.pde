public class Dashboard
{
    private MSButton face;
    private int initMilli;
    private int elapMilli;
    private boolean timerRunning;
    private int flagsLeft;
    private int minutes, seconds;
    private String secondsString;

    public Dashboard()
    {
        flagsLeft = NUM_BOMBS;
        face = new MSButton((width / 2) - 20, height - 50);
        face.setLabel("🙂");
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

    public void setLabel(String label)
    {
        face.setLabel(label);
    }

    public void draw() {
        flagsLeft = NUM_BOMBS - countMarked();
        if (timerRunning) {
            elapMilli = millis() - initMilli;
            minutes = elapMilli / 60000;
            seconds = (elapMilli % 60000) / 1000;
            secondsString = "";
            if (seconds < 10)
                secondsString += "0";
            secondsString += seconds;
        }
        fill(45, 45, 45);
        rect(5, height - 50, width - 10, 45, 5); 
        fill(255);
        textSize(25);
        text("🚩 " + flagsLeft, (width / 4) - 20, height - 32.5);
        text("⏱ " + minutes + ":" + secondsString, (width * 3 / 4) + 20, height - 32.5);
        textSize(15);
        if (status == 2)
            face.setLabel("😖");
        else if (status == 3)
            face.setLabel("😎");
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