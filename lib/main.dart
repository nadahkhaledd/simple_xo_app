import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xo_game/playerTitle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int xCount=0, oCount=0, playedSquares=0;
  bool xTurn = true;
  List<String> squares = ['', '', '', '', '', '', '', '', ''];

  noAction()
  {
    setState(() {

    });
  }

  pressedSquare(int i)
  {
    setState(() {
      if(squares[i]=='') {
        if (xTurn) squares[i] = 'X';
        else squares[i] = 'O';
        playedSquares++;
    }
      xTurn = !xTurn;
      check();
    });
  }

  check()
  {
    //Horizontal
    if (squares[0] == squares[1] &&
        squares[1] == squares[2] &&
        squares[0] != '') {
      notify(squares[0]);
    }
    if (squares[3] == squares[4] &&
        squares[4] == squares[5] &&
        squares[3] != '') {
      notify(squares[3]);
    }
    if (squares[6] == squares[7] &&
        squares[7] == squares[8] &&
        squares[6] != '') {
      notify(squares[6]);
    }

    // Checking Vertical
    if (squares[0] == squares[3] &&
        squares[0] == squares[6] &&
        squares[0] != '') {
      notify(squares[0]);
    }
    if (squares[1] == squares[4] &&
        squares[1] == squares[7] &&
        squares[1] != '') {
      notify(squares[1]);
    }
    if (squares[2] == squares[5] &&
        squares[2] == squares[8] &&
        squares[2] != '') {
      notify(squares[2]);
    }

    // Diagonal
    if (squares[0] == squares[4] &&
        squares[0] == squares[8] &&
        squares[0] != '') {
      notify(squares[0]);
    }
    if (squares[2] == squares[4] &&
        squares[2] == squares[6] &&
        squares[2] != '') {
      notify(squares[2]);
    } else if (playedSquares == 9) {
      draw();
    }
  }

  notify(var x)
  {
    setState(() {
      if (x == 'X') {
        xCount++;
        x = 'Player 1';
      }
      else if (x == 'O') {
        oCount++;
        x = 'Player2';
      }
    });


    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text( x + " wins!"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                 clear();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  draw()
  {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  clear();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  clear()
  {
    setState(() {
      for (int i = 0; i < 9; i++) {
        squares[i] = '';
      }
      playedSquares = 0;
      xTurn = true;
    });
  }

  startOver()
  {
    setState(() {
      xCount = 0;
      oCount = 0;
      for (int i = 0; i < 9; i++) {
        squares[i] = '';
      }
    });
    playedSquares = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.black54,
         toolbarOpacity: 0.5,
         bottomOpacity: 0.5,
         title: Text('Tic Tac Toe'),
      ),
      body:
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PlayerTitle('Player 1', 'Player 2'),
            ),
            PlayerTitle('$xCount', '$oCount'),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int place) {
                      return GestureDetector(
                        onTap: () {
                          pressedSquare(place);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Center(
                            child: Text(
                              squares[place],
                              style: TextStyle(color: Colors.red, fontSize: 35),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Colors.black, // foreground
                        ),
                        onPressed: startOver,
                        child: Text("   Start Over   "),
                      )
                    ],
                  ),
                ))
          ],
        ),

    );
  }
}
