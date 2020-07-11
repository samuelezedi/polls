# Polls

[![pub package](https://img.shields.io/badge/pub-0.2.1-brightgreen)](https://pub.dev/packages/polls)


[GitHub](https://github.com/samuelezedi/polls)

## ScreenShots

| Voting | Not Voted Yet | Voted |
| ------------- | ------------- | ------------- |
| <image width="200" src="https://raw.githubusercontent.com/samuelezedi/polls/master/example/assets/3.gif"> | <image width="200" src="https://raw.githubusercontent.com/samuelezedi/polls/master/example/assets/1.jpeg"> | <image width="200" src="https://raw.githubusercontent.com/samuelezedi/polls/master/example/assets/2.jpeg"> |


## Usage

Basic:

```dart
import 'package:polls/polls.dart';
```

```dart
Polls(
    children: [
        // This cannot be less than 2, else will throw an exception
        Polls.options(title: 'Cairo', value: option1),
        Polls.options(title: 'Mecca', value: option2),
        Polls.options(title: 'Denmark', value: option3),
        Polls.options(title: 'Mogadishu', value: option4),
        ],
        question: Text('What is the capital of Egypt'),
        currentUser: this.user,
        creatorID: this.creator,
        voteData: usersWhoVoted,
        userChoice: usersWhoVoted[this.user],
        onVoteBackgroundColor: Colors.blue,
        leadingBackgroundColor: Colors.blue,
        backgroundColor: Colors.white,
        onVote: (choice) {

            setState(() {
              this.usersWhoVoted[this.user] = choice;
            });
            if (choice == 1) {
            setState(() {
                option1 += 1.0;
            });
            }
            if (choice == 2) {
            setState(() {
                option2 += 1.0;
            });
            }
            if (choice == 3) {
            setState(() {
                option3 += 1.0;
            });
            }
            if (choice == 4) {
            setState(() {
                option4 += 1.0;
            });
        }
    },
);
```

### Poll View type

```dart
Polls(
  viewType: PollsType.creator
);
```

```dart
Polls(
viewType: PollsType.voter
);
```


```dart
Polls(
viewType: PollsType.readOnly
);
```


## Why I made this plugin

Apparently, I have built 2 apps that required user voting processes, twice I had to implement same code on different apps.
I also had to share the code with a friend, well I thought it would not be a bad idea to create a package off it, cause at this
time there was no polls widget package on pub.dev

### kindly follow on github
[github](https://github.com/samuelezedi)

## Kindly follow me on
[twitter](https://twitter.com/samuelezedi)
[medium](https://medium.com/@samuelezedi)
[instagram](https://instagram.com/samuelezedi)