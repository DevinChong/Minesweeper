public class Dashboard
{
    private MSButton face;
    private int initMilli;
    private int elapMilli;
    private boolean timerRunning;
    private int flagsLeft;
    private int minutes, seconds;

    public Dashboard()
    {
        flagsLeft = NUM_BOMBS;
        face = new MSButton((width / 2) - 20, height - 50);
        face.setLabel("🙂");
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

    public int getFlagsLeft()
    {
        return flagsLeft;
    }

    public void setFlagsLeft(int num)
    {
        flagsLeft = num;
    }

    public void draw() {
        if (timerRunning) {
            elapMilli = millis() - initMilli;
            minutes = elapMilli / 60000;
            seconds = (elapMilli % 60000) / 1000;
        }
        fill(45);
        rect(5, height - 50, width - 10, 45, 5); 
        if (status != 0)
        {
            fill(255);
            textSize(30);
            text("🚩 " + flagsLeft, (width / 4) - 20, height - 32.5);
            text("⏱ " + minutes + ":" + String.format("%02d", seconds), (width * 3 / 4) + 20, height - 32.5);
        }
        textSize(20);
        if (status == 2)
            face.setLabel("😖");
        else if (status == 3)
            face.setLabel("😎");
    }

}