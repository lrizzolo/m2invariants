import java.util.*;

public class Invariants
{

    private static class Entry 
    {
        private int degrees[];
        private int numVars, degree;

        public Entry(int numVars)
        {
            this.numVars = numVars;
            degrees = new int[numVars];
            for (int i = 0; i < numVars; i++) degrees[i] = 0;
            degree = 999999;
        }

        public int getNumVars()
        {
            return numVars;
        }

        public int getDegree()
        {
            return degree;
        }

        public int[] getDegrees()
        {
            return degrees.clone();
        }

        public void setDegrees(int[] newDegrees)
        {
            degree = 0;

            for (int i = 0; i < numVars; i++) 
            {
                degrees[i] = newDegrees[i];
                degree += newDegrees[i];
            }
        }

        public String toString()
        {
            String out = "" + degree + " ";
            out += degrees[0];

            for (int i = 1; i < numVars; i++) 
            {
                out += ", " + degrees[i];
            }
            return out;
        }

    }

    public static Entry addEntries(Entry a, Entry b)
    {
        int numVars = a.getNumVars();
        Entry total = new Entry(numVars);
        int degrees[] = new int[numVars];
        for (int i = 0; i < numVars; i++)
        {
            degrees[i] = a.getDegrees()[i] + b.getDegrees()[i];
        }
        total.setDegrees(degrees);
        return total;
    }

    public static void main(String[] args) {
        Entry dp[][];
        int d1 = 5, d2 = 5, numVars = 3;

        dp = new Entry[d1][d2];
        for (int i = 0; i < d1; i++)
        {
            for (int j = 0; j < d2; j++) 
            {
                dp[i][j] = new Entry(numVars);
            }
        }
        int initializeDegrees[] = {0,0,0};
        dp[0][0].setDegrees(initializeDegrees);

        for (int i = 0; i < d1; i++)
        {
            for (int j = 0; j < d2; j++) 
            {
                System.out.print(dp[i][j] + "\t");
            }
            System.out.println();
        }

        int weights[][] = {{2,0,2},{0,2,2}};

        ArrayList<int[]> updated = new ArrayList<int[]>();
        int[] updateCoords = {0,0};
        updated.add(updateCoords);
        while (!updated.isEmpty())
        {
            int[] coords = updated.remove(updated.size()-1);

            for (int i = 0; i < numVars; i++)
            {
                int x = coords[0] + weights[0][i];
                int y = coords[1] + weights[1][i];

                x %= d1;
                y %= d2;

                Entry e = new Entry(numVars);
                int degrees[] = new int[numVars];
                degrees[i] = 1;
                e.setDegrees(degrees);

                Entry newEntry = addEntries(dp[coords[0]][coords[1]],e);

                if (true || newEntry.getDegree() <= dp[x][y].getDegree())
                {
                    
                if (newEntry.getDegree() < 10 && (x != 0 || y != 0))
                {
                    dp[x][y] = newEntry;
                    int newCoords[] = {x,y};
                    updated.add(newCoords);
                }
                }


                if (x == 0 && y == 0)
                {

                    System.out.println(newEntry);

                    ;

                }

                
            }
        }

        
        for (int i = 0; i < d1; i++)
        {
            for (int j = 0; j < d2; j++) 
            {
                System.out.print(dp[i][j] + "\t");
            }
            System.out.println();
        }

        return;
    }
}
