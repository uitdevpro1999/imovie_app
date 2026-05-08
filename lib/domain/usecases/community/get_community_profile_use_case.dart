import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityProfileParams {
  const GetCommunityProfileParams({required this.userId});

  final String userId;
}

class GetCommunityProfileUseCase
    implements UseCase<CommunityProfile, GetCommunityProfileParams> {
  const GetCommunityProfileUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityProfile>> call(GetCommunityProfileParams params) {
    return repository.getProfile(params.userId);
  }
}
