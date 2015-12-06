//This program displays the deaths due to alcohol and drugs in Maryland between 2007-2013. The data is displayed using a linegraph, barchart and wordchart.
//David Hunt
void setup()
{
  size(700,700); 
 
  border=width*.1;
  
  //calling my methods
  loadData();
  sumYears();
  sumCounty();
}

//This array list is of type SortLists which will be used to hold all my data
ArrayList<SortLists> dlist =new ArrayList<SortLists>();
ArrayList<ArrayList<Float>> info=new ArrayList<ArrayList<Float>>();
ArrayList<SortLists> list=new ArrayList<SortLists>();

float border;
int numYears=7;
int numCounties=24;
//maxY is used to round of the top value on the y axis to the nearest 10.
float maxY;

float [] yearSums =new float[numYears];
float[] countySums =new float[numCounties];
float[] temp;
int graph=1;

void draw()
{
  
  background(255,0,0);
  stroke(0);
  fill(255);
  
  //Used so the user can change between graphs
  if(keyPressed)
  {
     if(key=='1')
     {
       //line graph
        graph=1; 
     }
     if(key=='2')
     {
       //barchart
        graph=2; 
        temp=new float[24]; 
     }
     if(key=='3')
     {
        graph=3; 
     }
  }
  
  //if linegraph
  if(graph==1)
  {
      textAlign(CENTER,CENTER);
      text("Drug & Alcohol related Deaths Each Year in Maryland (2007-2013)",width/2,border*.5);
      //get max for each year
      float max=yearMaxSum(yearSums);
      float avg=lineGraphAvg();
      drawAxis(max);
      drawLineGraph(avg);
      getdets(max,yearSums);
      
  }
  
  //if barchart
  if(graph==2)
  {
    textAlign(CENTER,CENTER);
    text("Drug & Alcohol related Deaths per County in Maryland (2007-2013)",width/2,border*.5);
    //get max for each county
    float max=yearMaxSum(countySums);
    drawAxis(max);
    drawBarChart();
    getdets(max,countySums);
    
  }
  
  if(graph==3)
  {
     textAlign(CENTER,CENTER);
     textSize(12);
     text("Drug & Alcohol related Deaths per County in Maryland (2007-2013)",width/2,border*.5);
     float max=yearMaxSum(countySums);
     drawWordChart(max); 
  }
 
}


//This method loads the data from the .csv file in the data folder and sorts it by encapsulating using a class called SortLists
void loadData()
{
   //Load the data from my .csv file int the sketch
   String[] lines=loadStrings("drug_alcohol_deaths.csv");
   
   for(int i=1;i<lines.length-1;i++)
   {  
     //Split the string where a "," is found
      String[] data=lines[i].split(",");
      
      
      //Creates a SortList called perCounty. My data will be passed to the method SortLists and sort it for later use and place it in perCounty
      //**
      SortLists perCounty= new SortLists(data);
      SortLists County=new SortLists(data);
      //For every loop the perCounty is added to my dlist
      dlist.add(perCounty); 
   }
 
}

//This method sums up all the values for each year. These sums will be used in my line graph
void sumYears()
{
    for(int i=0;i<dlist.size();i++)
    {
      yearSums[0]+=dlist.get(i).y2007;
      yearSums[1]+=dlist.get(i).y2008;
      yearSums[2]+=dlist.get(i).y2009;
      yearSums[3]+=dlist.get(i).y2010;
      yearSums[4]+=dlist.get(i).y2011;
      yearSums[5]+=dlist.get(i).y2012;
      yearSums[6]+=dlist.get(i).y2013;
    }
    
}

//This method sums up all the values for each county
void sumCounty()
{
   for(int i=0;i<dlist.size();i++)
   {
      countySums[i]+=dlist.get(i).y2007;
      countySums[i]+=dlist.get(i).y2008;
      countySums[i]+=dlist.get(i).y2009;
      countySums[i]+=dlist.get(i).y2010;
      countySums[i]+=dlist.get(i).y2011;
      countySums[i]+=dlist.get(i).y2012;
      countySums[i]+=dlist.get(i).y2013;
   }
}

//This method draws the axises
void drawAxis(float max)
{
  
   float windowsp=width-border*2;
   textSize(12);
   
    //y-axis
    line(border,border,border,height-border);
    
    //Round the max value to the nearest 10
    maxY=findMaxWindow(max);
    
    //NumyVal is the amount of ticks I want on the y-axis. I chose 10
    int NumyVal=10;
    float yGap=windowsp/NumyVal;
    
    for(int i=0;i<=NumyVal;i++)
    {
        //The y values that are beside the ticks 
        text((int)map(i,0,NumyVal,0,maxY),border*.5,height-(yGap*i)-border);
        
        //ticks for y-axis
        line(border,height-(yGap*i)-border,border*.75,height-(yGap*i)-border);
    }
    
    
    
    //x-axis
    line(border,height-border,width-border,height-border);
    
    float xGap=windowsp/(yearSums.length-1);
    
    if(graph==1)
    {
      for(int i=0;i<=yearSums.length;i++)
      {
         //The x values that are below the ticks
         text((int)map(i,0,yearSums.length-1,2007,2013),(i*xGap)+border,height-(border*.5));
         
         //ticks for x-axis
         line((i*xGap)+border,height-border,(i*xGap)+border,height-(border*.75));
      }
    }
}

//This method finds what the max value to map the y values of the line graph to. This is used to make the y-axis look nicer.
float findMaxWindow(float max)
{
   while(max%10!=0)
    {
       max++;
    } 
    
    return max;
}

//Finds the max value in the yearSums array.
float yearMaxSum(float [] Sums)
{
   
   float max=Sums[0];
   
   for(int i=1;i<Sums.length;i++)
   {
     if(max<Sums[i])
    {
       max=Sums[i];
    } 
   }
   
   return max;
  
}

//This methd displays details to the user
void getdets(float max,float[] array)
{
  //windowsp is the actual amount of space I can use for my graph in the x and y directions
  float windowsp=width-(border*2);
  float xGap=windowsp/array.length;
  //space is used so the user can see the details displayed 15 pixels away from the mouse pointer
  int space=15;
  fill(255);
  
  
  //if the x value of the mouse position is within the graph
  if(mouseX>border && mouseX<width-border)
  {
     //mouseXpos is used to decide which value from yearSums to display
    float mouseXpos=(mouseX-border)/xGap;
    float y=(height-map(array[(int)mouseXpos],0,max,0,windowsp))-border; 
    float x=map((int)mouseXpos,0,array.length,0,windowsp+border);
    
    //if user is viewing the line graph
    if(graph==1)
    {
    text((int)(array[(int)mouseXpos])+" died",border+x,y-space);
    line(x+border,y,mouseX,mouseY);
    }
    
    //if the user is viewing the barchart
    if(graph==2)
    {
      if(mouseY>y)
      {
        text(dlist.get((int)mouseXpos).county + ": " + (int)(array[(int)mouseXpos]),mouseX+space,mouseY-space);
      }
    }
  }
}

//This method calculates the average of yearSums.
float lineGraphAvg()
{
   float sum=0;
   
   for(float f: yearSums)
   {
      sum+=f; 
   }
   
   float avg=sum/yearSums.length;
   return(avg);
}

//GRAPHS

//This method draws the line graph which represents the the sum of deaths per year
void drawLineGraph(float avg)
{
  //windowsp is the actual amount of space I can use for my graph in the x and y directions
  float windowsp=width-(border*2);
  
  for(int i=1;i<yearSums.length;i++)
  {
    //the previous x and y are mapped aswell as the x and y values. This will help fit the data into my graph
    float px=map(i-1,0,numYears,0,windowsp+border);
    float py=map(yearSums[i-1],0,maxY,0,windowsp);
    float x=map(i,0,numYears,0,windowsp+border);
    float y=map(yearSums[i],0,maxY,0,windowsp);
    
    //draws the trend between current and previous points
    fill(0);
    line((px)+border,(height-py)-border,x+border,(height-y)-border);
    
    //I draw circles at each point to make it easier to see the various points in the line graph
    fill(255);
    ellipse((px)+border,(height-py)-border,10,10);
    
    if(i==yearSums.length-1)
    {
       ellipse((x)+border,(height-y)-border,10,10);
    }

  }  
 
  //draw the average line
  stroke(0,255,0);
  float avgline=map(avg,0,maxY,0,windowsp);
  line(border,(height-avgline)-border,width-border,(height-avgline)-border);
  textAlign(CENTER,CENTER);
  text("Avg:\n" + (int)avg,width-(border*.5),(height-avgline)-border);

}

//This method draws a barchart to represent the sum of deaths over the seven years per county
void drawBarChart()
{
    //windowsp is the actual amount of space I can use for my graph in the x and y directions
    float windowsp=width-(border*2);
    //the width of each bar
    float bWidth=windowsp/dlist.size();
    
    
  
   //draw the same amount of bars as the data that im using
   for(int i=0;i<dlist.size();i++)
   {
     //x is the x position of the rect
     float x=(bWidth*i)+border;
     //y is the y position of the rect
     float y=height-border;
     //how tall each bar is calculated and mapped.
     float bHeight=map(countySums[i],0,maxY,0,windowsp);

     fill(dlist.get(i).colour);
     rect(x,y,bWidth,-temp[i]);
     
     if(temp[i]<bHeight)
     {
       if(countySums[i]%2==0)
       {
          temp[i]+=2; 
       }
       temp[i]+=1;
     }
     
   } 
}

//This method displays a word chart
void drawWordChart(float max)
{
  //maxTxtSize is the text size that all word will be scaled to
  float maxTxtSize=width*.25;
  float thetaInc;
  //Each word is displayed equi distant from the centre and evenly along the circumfrence
  thetaInc=TWO_PI/dlist.size();
  float cx=width/2;
  float cy=height/2;
  
  
  for(int i=0;i<dlist.size();i++)
  {
    float scale=max/countySums[i];
    float theta=i*thetaInc;
    float x;
    float y;
    float r=width*.35;
    fill(dlist.get(i).colour);
    
    //Text size is scaled to the maxTxtSize
    textSize(maxTxtSize/scale);
    
    //this if statement is to try and ensure no overlapping of words
    if(scale>10)
    {
       r=r+50;
    }
    x=cx+sin(theta)*r;
    y=cy-cos(theta)*r;
    
    //if scale==1 then this county has the maximum amount of deaths. I want to display the largest county in the middle
    if(scale==1)
    {
       x=cx;
       y=cy;
    }
    
     text(dlist.get(i).county,x,y); 
     stroke(0,255,255);
  }
}

