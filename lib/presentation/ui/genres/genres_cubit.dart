import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/presentation/ui/genres/genres_state.dart';

class GenresCubit extends BaseCubit<GenresState> {
  GenresCubit({required List<HomeGenre> genres})
    : super(GenresState(genres: genres));
}
