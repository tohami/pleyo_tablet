
import 'package:pleyo_tablet_app/base/base_repositroy.dart';
import 'package:pleyo_tablet_app/model/strapi/group_competition.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/data/tickets_api_provider.dart';
import '../../../model/strapi/ticket.dart';
import 'group_api_provider.dart';

abstract class IGroupsRepository {
  Future<GroupCompetition> createGroupCompetition(GroupCompetition data);
  // Future<Score> updateScoreStatus(String status,int scoreId);
}

class GroupsRepository extends BaseRepository
    implements IGroupsRepository {
  IGroupsProvider provider;

  GroupsRepository({required this.provider});

  @override
  Future<GroupCompetition>  createGroupCompetition(GroupCompetition data) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.createGroup(data) ;
    if(apiResponse.isOk && apiResponse.body != null){
      return apiResponse.body!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }
  // @override
  // Future<Score> updateScoreStatus(String status,int scoreId) async{
  //   // TODO: implement getAllMerchants
  //   final apiResponse = await provider.updateScoreStatus(status,scoreId) ;
  //   if(apiResponse.isOk && apiResponse.body?.data != null){
  //     return apiResponse.body!.data!;
  //   }else {
  //     throw(getErrorMessage(apiResponse.bodyString!)) ;
  //   }
  // }
}
