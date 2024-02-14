
import 'package:pleyo_tablet_app/base/base_repositroy.dart';
import 'package:pleyo_tablet_app/model/strapi/group.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/data/tickets_api_provider.dart';
import '../../../model/strapi/ticket.dart';
import 'group_api_provider.dart';

abstract class IGroupsRepository {
  Future<Score> startGroup(int groupDifficulty,int groupVariant,int ticketId);
  Future<Score> updateScoreStatus(String status,int scoreId);
}

class GroupsRepository extends BaseRepository
    implements IGroupsRepository {
  IGroupsProvider provider;

  GroupsRepository({required this.provider});

  @override
  Future<Score> startGroup(groupDifficulty, groupVariant, ticketId) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.startGroup(groupDifficulty, groupVariant, ticketId) ;
    if(apiResponse.isOk && apiResponse.body?.data != null){
      return apiResponse.body!.data!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }
  @override
  Future<Score> updateScoreStatus(String status,int scoreId) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.updateScoreStatus(status,scoreId) ;
    if(apiResponse.isOk && apiResponse.body?.data != null){
      return apiResponse.body!.data!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }
}
