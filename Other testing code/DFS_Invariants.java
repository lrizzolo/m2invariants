import java.util.*;

public class DFS_Invariants
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

        public boolean equals(Object object)
        {
            if (object == null || !(object instanceof Entry)) return false;

            Entry other = (Entry) object;
            //if (this.getDegree() != other.getDegree()) return false;

            int[] thisDeg = this.getDegrees(), otherDeg = other.getDegrees();
            for (int i = 0; i < numVars; i++)
            {
                if (thisDeg[i] < otherDeg[i]) return false;
            }
            return true;

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

    public static int d1 = 13, d2 = 17, numVars = 3;
    public static int bound = d1*d2+1;

    public static ArrayList<Entry> invariants = new ArrayList<Entry>();
    public static int weights[][] = {{1,0,1},{0,1,2}};

    public static void dfs(Entry prev, int[] coords)
    {
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

            Entry newEntry = addEntries(prev,e);


            if (newEntry.getDegree() < bound && (x != 0 || y != 0))
            {
                int newCoords[] = {x,y};
                dfs(newEntry,newCoords);
            }


            if (x == 0 && y == 0 && newEntry.getDegree() <= bound)
            {


                if (!invariants.contains(newEntry))
                {
                    invariants.add(newEntry);
                    System.out.println(newEntry);
                }

            }

        }
    }

    public static void bfs()
    {
        Queue<int[]> updated = new LinkedList<>();
        Queue<Entry> entries = new LinkedList<>();



        int initializeDegrees[] = {0,0,0};
        Entry start = new Entry(numVars);
        start.setDegrees(initializeDegrees);

        int[] updateCoords = {0,0};
        updated.add(updateCoords);
        entries.add(start);

        int currentDeg = 0;
        while (!updated.isEmpty())
        {
            int[] coords = updated.remove();
            Entry prev = entries.remove();

            int firstNonzero = 0;

            //System.out.println("Current: " + prev.toString());

            if (prev.getDegree() != 0)
            {
                if (currentDeg < prev.getDegree())
                {
                    currentDeg = prev.getDegree();
                    System.out.println("Current Degree: " + currentDeg);
                }
                int[] prevDegs = prev.getDegrees();
                for (int i = 0; i < numVars; i++)
                {
                    if (prevDegs[i] != 0)
                    {
                        firstNonzero = i;
                        break;
                    }
                }
            }
            firstNonzero = 0;
            for (int i = firstNonzero; i < numVars; i++)
            {
                int x = coords[0] + weights[0][i];
                int y = coords[1] + weights[1][i];

                x %= d1;
                y %= d2;

                Entry e = new Entry(numVars);
                int degrees[] = new int[numVars];
                degrees[i] = 1;
                e.setDegrees(degrees);

                Entry newEntry = addEntries(prev,e);

                if (newEntry.getDegree() < bound && (x != 0 || y != 0))
                {
                    int newCoords[] = {x,y};
                    if (!entries.contains(newEntry) && !invariants.contains(newEntry))
                    {
                        updated.add(newCoords);
                        entries.add(newEntry);
                    }
                }


                if (x == 0 && y == 0 && newEntry.getDegree() <= bound)
                {


                    if (!invariants.contains(newEntry))
                    {
                        invariants.add(newEntry);
                        System.out.println(newEntry);
                    }

                }

            }
        }
    }

    public static void main(String[] args) {
        Entry dp[][];

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



        Entry start = new Entry(numVars);
        start.setDegrees(initializeDegrees);
        int startCoords[] = {0,0};

        //dfs(start, startCoords);
        bfs();




        return;
    }
}
