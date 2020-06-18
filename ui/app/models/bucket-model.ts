null

### @ngInject ###
global.cobudgetApp.factory 'BucketModel', (BaseModel) ->
  class BucketModel extends BaseModel
    @singular: 'bucket'
    @plural: 'buckets'
    @indices: ['groupId', 'userId']
    @serializableAttributes: ['description', 'name', 'target', 'groupId']

    relationships: ->
      @hasMany 'comments', sortBy: 'createdAt', sortDesc: false
      @hasMany 'contributions', sortBy: 'createdAt', sortDesc: false
      @belongsTo 'group'
      @belongsTo 'author', from: 'users', by: 'userId'

    amountRemaining: ->
      @target - @totalContributions

    percentFunded: ->
      @totalContributions / @target * 100

    openForFunding: ->
      @remote.postMember(@id, 'open_for_funding')

    cancel: ->
      @remote.postMember(@id, 'archive')

    complete: ->
      @remote.postMember(@id, 'paid')

    hasComments: ->
      @numOfComments > 0

    contributionsByUser: (user) ->
      @recordStore.contributions.find(bucketId: @id, userId: user.id)

    amountContributedByUser: (user) ->
      _.sum @contributionsByUser(user), (contribution) ->
        contribution.amount

    amountContributedByOthers: (user) ->
      @totalContributions - @amountContributedByUser(user)

    percentContributedByOthers: (user) ->
      @amountContributedByOthers(user) / @target * 100

    percentContributedByUser: (user) ->
      @amountContributedByUser(user) / @target * 100

    isArchived: ->
      !!@archivedAt && !@paidAt

    isIdea: ->
      @status == 'draft' && !@archivedAt

    isFunding: ->
      @status == 'live' && !@archivedAt

    isFunded: ->
      @status == 'funded' && !@paidAt

    isComplete: ->
      !!@paidAt && @status == 'funded'

    isCancelled: ->
      !!@archivedAt && !@paidAt && @status != 'funded'

    ## Legacy funded and archived bucket
    isFundedAndArchived: ->
      @status == 'funded' && !@paidAt && !!@archivedAt
