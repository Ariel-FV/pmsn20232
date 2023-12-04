import 'package:flutter/material.dart';
import 'package:pmsn20232/models/peli/actor_model.dart';
import 'package:pmsn20232/models/peli/popular_model.dart';
import 'package:pmsn20232/network/peli/api_popular.dart';
import 'package:pmsn20232/widgets/peli/actor_card_info.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatelessWidget {
  ApiPopular apiPopular = ApiPopular();

  final PopularModel popularModel;
  MovieDetailScreen({Key? key, required this.popularModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 60, 60, 60),
        title: Text(popularModel.title!),
      ),
      body: Hero(
        tag: popularModel.id!,
        child: 
          _buildMobileLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/' +
                      popularModel.backdropPath!,
                ),
                fit: BoxFit.fill,
                opacity: 0.5,
              ),
            ),
            padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Text(
                  popularModel.title!,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 255, 230, 0),
                    ),
                    SizedBox(width: 10),
                    Text(
                      popularModel.voteAverage!.toString() + '/100',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 230, 0),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Sinopsis',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  popularModel.overview!,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30),
                Text(
                  'Actores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                FutureBuilder<List<ActorModel>?>(
                  future: apiPopular.getAllAuthors(popularModel),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            ActorModel actor = snapshot.data![index];
                            return ActorCard(
                              name: actor.name!,
                              photoUrl: actorp(actor),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: apiPopular.getIdVideo(popularModel.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: snapshot.data.toString(),
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                            controlsVisibleAtStart: true,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Color.fromARGB(225, 54, 244, 231)                    );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  actorp(ActorModel actor2){
    if(actor2.profilePath==null){
      return 'https://pluspng.com/img-png/user-png-icon-download-icons-logos-emojis-users-2240.png';
    }else{
      return 'https://image.tmdb.org/t/p/original${actor2.profilePath}';
    }
  }
}
