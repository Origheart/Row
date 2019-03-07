# Row

简单几行代码就可以呈现复杂列表页，大大简化`Controller`复杂度。

## 使用：

* 构建`Rows`（举例而已，假设页面UI很复杂）:

```Swift
private var rows: [RowType] = []

func getVoteDetails(voteId: String, completion: (() -> Void)? = nil) {
        OFFSchoolProvider.sharedInstance().getSchoolVoteDetail(withVoteId: voteId, success: { [weak self] (voteModel) in
            self?.rows.removeAll()
            if let schools = voteModel.schools {
                let row = Row<VoteSchoolCell>(viewData: schools)
                self?.rows.append(row)
            }
            if let vote = voteModel.vote {
                self?.pkTitle = vote.title
                let row = Row<VoteCell>(viewData: vote)
                self?.rows.append(row)
            }
            if let analysis = voteModel.opinions {
                let row = Row<VoteAnalysisCell>(viewData: analysis)
                self?.rows.append(row)
            }
            if let banner = voteModel.banner {
                let row = Row<SingleBannerCell>(viewData: banner)
                self?.rows.append(row)
            }
            self?.tableView.reloadData()
            completion?()
        }) { [weak self] (err) in
            let errorMsg = err?.message() ?? ""
            OFFProgressHUD.showInfo(withStatus: errorMsg)
        }
    }
```

* 使用`rows`:

```Swift
extension OFFNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        row.update(cell: cell)
        return cell
    }
```


